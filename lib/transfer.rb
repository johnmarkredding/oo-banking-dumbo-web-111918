class Transfer
  attr_reader :amount, :sender, :receiver
  attr_accessor :status
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def reject_transfer
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

  def execute_transaction
    if self.valid? && self.sender.balance > self.amount && self.status != "complete"
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
      self.status = "complete"
    else
      self.reject_transfer
    end
  end

  def reverse_transfer
    if self.status == "complete" && self.valid? && self.receiver.balance > self.amount
      receiver.balance -= self.amount
      sender.balance += self.amount
      self.status = "reversed"
    else
      self.reject_transfer
    end
  end
end
