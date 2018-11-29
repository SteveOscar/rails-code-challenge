class Order < ApplicationRecord
  has_many :line_items
  accepts_nested_attributes_for :line_items, reject_if: proc { |attributes| missing_attributes(attributes) }

  scope :shipped, -> { where.not(shipped_at: nil).order(shipped_at: :asc) }
  scope :unshipped, -> { where(shipped_at: nil) }

  def expedited?
    @expedite
  end

  def returnable?
    @returns
  end

  def settings(opts = {})
    @expedite = opts[:expedite].presence
    @returns = opts[:returns].presence
    @warehouse = opts[:warehouse].presence
  end

  def shipped?
    shipped_at.present?
  end

  def warehoused?
    @warehouse
  end

  def display_shipping
    shipped_at.strftime("%m/%d/%Y at %I:%M %p")
  end

  private

  # TODO: not sure this is setup correctly
  def missing_attributes(attributes)
    attributes[:quantity].blank? || attributes[:unit_price].blank? || attributes[:widget_id].blank?
  end
end
