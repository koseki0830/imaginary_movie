class RankingsController < ApplicationController
  skip_before_action :require_login
  def sum
    @top_users = User.all.sort_by { |user| user.total_bookmarks_count }.reverse.take(3)
  end
end
