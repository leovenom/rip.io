module ApplicationHelper
  def card_classes(index)
    classes = %w[card]

    classes << 'first-card' if (index % 3).zero?
    classes << 'center-card' if (index % 3) == 1
    classes << 'last-card' if (index % 3) == 2

    classes.join(' ')
  end
end
