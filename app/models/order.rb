class Order < ApplicationRecord
  has_many :line_items
  accepts_nested_attributes_for :line_items, reject_if: proc {
    |atts| atts[:quantity].blank? || atts[:unit_price].blank? || atts[:widget_id].blank?
  }

  scope :shipped, -> { where.not(shipped_at: nil).order(shipped_at: :asc) }
  scope :unshipped, -> { where(shipped_at: nil) }

  def expedited?
    expedited
  end

  def returnable?
    returnable
  end

  def settings(opts = {})
    @expedite = update(expedited: true) if opts[:expedite].presence
    @returns = update(returnable: true) if opts[:returns].presence
    @warehouse = update(warehoused: true) if opts[:warehouse].presence
  end

  def shipped?
    shipped_at.present?
  end

  def warehoused?
    warehoused
  end

  def display_shipping
    shipped_at.strftime("%m/%d/%Y at %I:%M %p")
  end
end
