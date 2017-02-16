class InPastValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "should be in the past") unless in_past?(value)
  end

  private

    def in_past?(date)
      date.present? && date <= Time.zone.today
    end
end
