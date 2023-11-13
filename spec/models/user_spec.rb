require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションに関するテスト' do
    it '名前、メールアドレス、パスワードがある場合は有効' do
      valid_user = FactoryBot.build(:user)
      expect(valid_user).to be_valid
    end

    it '名前がない場合は無効' do
      user_without_name = FactoryBot.build(:user, name: '')
      expect(user_without_name).to be_invalid
    end

    it '名前が100文字を超える場合は無効' do
      long_name_user = FactoryBot.build(:user, name: 'a' * 101)
      expect(long_name_user).to be_invalid
    end

    it '重複した名前の場合は無効' do
      user = FactoryBot.create(:user)
      user_duplicate_name = FactoryBot.build(:user, name: user.name)
      expect(user_duplicate_name).to be_invalid
    end

    it 'メールアドレスがない場合は無効' do
      user_without_email = FactoryBot.build(:user, email: '')
      expect(user_without_email).to be_invalid
    end

    it '重複したメールアドレスの場合は無効' do
      user = FactoryBot.create(:user)
      user_duplicate_email = FactoryBot.build(:user, email: user.email)
      expect(user_duplicate_email).to be_invalid
    end

    it 'パスワードがない場合は無効' do
      user_without_password = FactoryBot.build(:user, password: '')
      expect(user_without_password).to be_invalid
    end

    it 'パスワードが3文字未満の場合は無効' do
      user_with_short_password = FactoryBot.build(:user, password: 'ab', password_confirmation: 'ab')
      expect(user_with_short_password).to be_invalid
    end

    it 'パスワード（確認用)とパスワードが一致しない場合は無効' do
      user_password_mismatch = FactoryBot.build(:user, password_confirmation: 'mismatch')
      expect(user_password_mismatch).to be_invalid
    end
  end

  describe 'own?メソッドに関するテスト' do
    let(:user) { FactoryBot.create(:user) }
    let(:movie) { FactoryBot.create(:movie, user: user) }
    let(:other_movie) { FactoryBot.create(:movie) }

    it '自分が投稿した映画の場合、trueを返す' do
      expect(user.own?(movie)).to be true
    end

    it '他のユーザーが投稿した映画の場合、falseを返す' do
      expect(user.own?(other_movie)).to be false
    end
  end
end
