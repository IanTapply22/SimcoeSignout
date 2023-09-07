module Core
  module Resources
    class Get < Grape::API
      params do
        optional :categories, type: String
        optional :available_on_date, type: String
      end

      get do
        resources = Resource.all
        if params[:categories].present?
          categories = params[:categories].split(",")
          resources = resources.where(category: categories)
        end
        if params[:available_on_date].present?
          resources = resources.select do |resource|
            bookings_on_date = ResourceBooking.get_bookings_for_resource_on_date(resource.name, params[:available_on_date]).count
            bookings_on_date != 4
          end
        end
        resources
      end
    end
  end
end