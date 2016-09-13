class SubmissionSingleSerializer < SubmissionEachSerializer
  self.root = false

  attributes :about, :experience, :os, :been_before, :reason, :extra, :partner,
             :displayed_position, :status

  has_many :rates
  has_many :comments

  def id
    object.id.to_s
  end

  def position
    list.index { |submission| submission.id == object.id }
  end

  def displayed_position
    pos = position || 0
    pos + 1
  end

  def status
    return "odrzucone" if object.rejected?

    return "ocenione (#{rates_count})" if rates_count >= Submission::MIN_RATES_COUNT

    "oczekuje (liczba ocen: #{rates_count})"
  end

  private

  def list
    @list ||= object.class.all.order(:id.asc).to_a
  end
end
