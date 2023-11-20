# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movies', type: :system do
  let!(:movie) { FactoryBot.create(:movie) }
  let!(:user) { FactoryBot.create(:user) }

  describe '映画一覧画面' do
    it '映画一覧画面が正しく表示される' do
      visit movies_path
      expect(page).to have_content('映画一覧')
      expect(page).to have_selector("img[src='#{movie.thumbnail.url}']")
      expect(page).to have_content(movie.title)
      expect(page).to have_content(movie.screening_time)
      movie.categories.each do |category|
        expect(page).to have_content(category.name)
      end
      expect(page).to have_content(movie.synopsis)
      expect(page).to have_content(movie.user.name)
      expect(page).to have_content(movie.created_at.strftime('%Y/%m/%d'))
      expect(page).to have_content(movie.bookmarks.count)
    end
  end

  describe '映画詳細画面' do
    it '映画情報が正しく表示される' do
      visit movie_path(movie)
      expect(page).to have_selector("img[src='#{movie.thumbnail.url}']")
      expect(page).to have_content(movie.title)
      expect(page).to have_content(movie.screening_time)
      movie.categories.each do |category|
        expect(page).to have_content(category.name)
      end
      expect(page).to have_content(movie.synopsis)
      expect(page).to have_content(movie.user.name)
      expect(page).to have_content(movie.created_at.strftime('%Y/%m/%d'))
      expect(page).to have_content(movie.bookmarks.count)
    end
  end

  describe '映画登録' do
    before do
      login_as(user)
      visit new_movie_path
    end

    context '有効な情報を入力した場合' do
      it '映画登録が完了し、映画詳細ページに遷移する' do
        fill_in 'タイトル', with: 'テストタイトル'
        fill_in '上映時間', with: 120
        select 'アクション', from: 'カテゴリー(複数選択可)'
        fill_in 'あらすじ', with: 'テストあらすじ'
        select '黒', from: 'ポスター画像のテキストの色'
        select '小', from: 'ポスター画像のテキストのサイズ'
        select '上部', from: 'ポスター画像のテキストの位置'
        attach_file 'ポスター画像', Rails.root.join('spec/support/assets/sample.jpg')
        click_button '登録する'

        expect(page).to have_content '映画を投稿しました!'
        expect(page).to have_content 'テストタイトル'
      end
    end

    context '無効な情報を入力した場合' do
      it '映画登録が失敗し、エラーメッセージが表示される' do
        fill_in 'タイトル', with: ''
        fill_in '上映時間', with: 120
        select 'アクション', from: 'カテゴリー(複数選択可)'
        fill_in 'あらすじ', with: 'テストあらすじ'
        select '黒', from: 'ポスター画像のテキストの色'
        select '小', from: 'ポスター画像のテキストのサイズ'
        select '上部', from: 'ポスター画像のテキストの位置'
        attach_file 'ポスター画像', Rails.root.join('spec/support/assets/sample.jpg')
        click_button '登録する'

        expect(page).to have_content '映画を投稿できませんでした'
        expect(page).to have_content 'タイトルを入力してください'
        expect(current_path).to eq new_movie_path
      end
    end
  end
end
