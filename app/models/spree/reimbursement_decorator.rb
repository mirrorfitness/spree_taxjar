# frozen_string_literal: true

module Spree::ReimbursementDecorator
  def self.prepended(base)
    base.include Taxable
    state_machine = base.state_machines[:reimbursement_status]
    state_machine.after_transition to: [:reimbursed], do: :remove_tax_for_returned_items
  end

  def remove_tax_for_returned_items
    return unless Spree::Config[:taxjar_enabled]
    return unless taxjar_applicable?(order)

    client = Spree::Taxjar.new(order, self)
    client.create_refund_transaction_for_order
  end
end

::Spree::Reimbursement.prepend(Spree::ReimbursementDecorator)
