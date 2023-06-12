module Api
  module V1
    class AppsController < ApplicationController
      def index
        app = App.all
        render json: app, status: :ok
      end

      def show
        app = App.find(params[:id])
        render json: app, status: :ok
      end
    end
  end
end
