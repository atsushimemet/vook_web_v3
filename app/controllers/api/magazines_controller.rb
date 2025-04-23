module API
  class MagazinesController < ApplicationController
    include Pagy::Backend

    def index
      scope_magazines = if admin_login?
                          Magazine.with_attached_thumbnail.order(publish_at: :desc)
                        else
                          Magazine.published.with_attached_thumbnail.order(publish_at: :desc)
                        end

      pagy, magazines = pagy(scope_magazines, limit: 16)

      render json: {
        magazines: MagazineResource.new(magazines),
        next: pagy.next
      }
    end
  end
end
