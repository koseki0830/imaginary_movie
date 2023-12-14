# frozen_string_literal: true

RailsAdmin.config do |config|
  config.asset_source = :sprockets

  config.authenticate_with do
    require_login

    unless current_user.admin?
      flash[:alert] = t('defaults.message.not_admin')
      redirect_to main_app.root_path unless current_user.admin?
    end
  end
  config.current_user_method(&:current_user)
  ## == CancanCan ==
  config.authorize_with :cancancan

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  config.parent_controller = 'ApplicationController'
end
