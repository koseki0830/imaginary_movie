# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'ユーザー登録' do
    before do
      visit new_user_path
    end

    context '有効な情報を入力した場合' do
      it 'ユーザー登録が完了し、映画一覧画面へ遷移する' do
        fill_in 'ユーザーネーム', with: 'テストユーザー'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'

        expect(page).to have_content 'ユーザー登録が完了しました!'
        expect(current_path).to eq movies_path
      end
    end

    context '無効な情報を入力した場合' do
      it 'ユーザー登録が失敗し、エラーメッセージが表示される' do
        fill_in 'ユーザーネーム', with: ''
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'

        expect(page).to have_content 'ユーザー登録ができませんでした'
        expect(page).to have_content 'ユーザーネームを入力してください'
      end
    end
  end

  describe 'ログイン' do
    before do
      @user = FactoryBot.create(:user)
      visit login_path
    end

    context '有効な情報を入力した場合' do
      it 'ログインが完了し、映画一覧画面へ遷移する' do
        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'

        expect(page).to have_content 'ログインしました!'
        expect(current_path).to eq movies_path
      end
    end

    context '無効な情報を入力した場合' do
      it 'ログインが失敗し、ログイン画面にレンダーされる' do
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'

        expect(page).to have_content 'ログインできませんでした'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ユーザー編集' do
    before do
      @user = FactoryBot.create(:user)
      login_as(@user)
      visit edit_users_path
    end

    context 'フォームの入力値が正常な場合' do
      it 'ユーザー情報更新に成功する' do
        fill_in 'ユーザーネーム', with: '新しい名前'
        fill_in 'メールアドレス', with: @user.email
        click_button '更新する'

        expect(page).to have_content 'ユーザー情報を更新しました'
        expect(current_path).to eq mypage_path
      end
    end

    context '無効な情報を入力した場合' do
      it 'ユーザー情報更新に失敗する' do
        fill_in 'ユーザーネーム', with: ''
        fill_in 'メールアドレス', with: @user.email
        click_button '更新する'

        expect(current_path).to eq edit_users_path
        expect(page).to have_content 'ユーザー情報が更新できませんでした'
        expect(page).to have_content 'ユーザーネームを入力してください'
      end
    end
  end
end
