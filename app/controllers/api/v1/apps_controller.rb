module Api
  module V1
    class AppsController < ApplicationController
      before_action :set_app, only: [:show]

      def index
        app = App.all
        render json: app, status: :ok
      end

      def show
        app = App.find(params[:id])
        render json: app, status: :ok
      end

      private

      def set_app
        App.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        head 404
      end
    end
  end
end
