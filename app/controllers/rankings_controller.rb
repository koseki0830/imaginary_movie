class RankingsController < ApplicationController
  def sum
    @top_users = User.select('id, name, total_bookmarks_count')
                .order('total_bookmarks_count DESC')
                .limit(3)
  end
end
