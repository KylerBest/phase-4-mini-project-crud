class SpicesController < ApplicationController
    def index
        render json: Spice.all, staus: :ok
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice
    rescue ActiveRecord::RecordNotFound
        render_not_found_message
    end

    def destroy
        find_spice.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound
        render_not_found_message
    end

    private

    def find_spice
        Spice.find(params[:id])
    end

    def render_not_found_message
        render json: {Error: "Spice not found"}, status: :not_found
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end
end
