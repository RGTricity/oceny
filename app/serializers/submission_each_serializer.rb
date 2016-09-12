class SubmissionEachSerializer < ActiveModel::Serializer
  attributes :id, :fullname, :adult, :email, :rates_count, :average_rate, :created_at, :rejected

  def id
    "#{object.id}"
  end

  def rates_count
    object.rates.count
  end

  def average_rate
    format("%.2f", object.average_rate) if object.average_rate
  end

  private

  def decorated
    @decorated ||= object.decorate
  end
end
