class SubmissionsController < ApplicationController

  def index
    collection = Submission.unscoped.rated.order(:average_rate.desc)
    fields = %w(
      fullname
      average_rate
      email
      about
      os
      been_before
      reason
      extra
      partner
      adult
      city
      phone
      experience
      information_source
      custom_information_source
      meal_preferences
      custom_meal_preferences
    )

    respond_to do |format|
      format.csv { render text: TextExporter.to_csv(collection, fields) }
    end
  end
end
