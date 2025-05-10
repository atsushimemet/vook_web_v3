module Admin
  class MagazinesController < ApplicationController
    before_action :require_admin_login, only: %i[index]

    def index
      @magazines = Magazine.all.order(:id)
    end
  end
end
