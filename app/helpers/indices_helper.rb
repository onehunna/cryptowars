module IndicesHelper
  def positive_negative_format(number, formatter: :precision, precision: 2)
    return unless number.present?

    klass = ''
    style = ''
    content = send("number_to_#{formatter}", number, precision: precision)

    if number > 0
      klass = 'positive'
      style = 'color: green'
      content = "+#{content}"
    elsif number < 0
      klass = 'negative'
      style = 'color: red'
    else
      klass = 'zero'
    end

    content_tag :span, content, class: klass, style: style
  end
end
