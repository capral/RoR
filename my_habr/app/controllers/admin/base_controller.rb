  class Admin::BaseController < Admin::BaseController

    before_action :authenticate_user!
    before_action :cheсk_admin

    layout 'admin'

    protected

    def cheсk_admin
      unless current_user.admin?
        redirect_to root_path,
                    alert: 'у вас нет прав на просмотр этой страницы!'
      end
    end
  end