# class DateValidator < ActiveModel::EachValidator
#   def validate_each(record, attribute, value)
#     if value <= Date.today
#       record.errors.add(attribute, '無効な値があります')
#     elsif value.sunday?
#       record.errors.add(attribute, '無効な値があります')
#     end
#   end
# end

