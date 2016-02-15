class PassAlong

  def self.all_variables(sender, receiver)
    sender.class.instance_methods(false).each do |method|
      new(sender, receiver, method).run
    end
  end

  attr_reader :sender, :receiver, :method

  def initialize(sender, receiver, method)
    @sender = sender
    @receiver = receiver
    @method = method
  end

  def run
    sender.class.after method do |*, obj|
      variables = get_variables_from(sender)
      variables.each do |var|
        receiver.instance_variable_set(var, sender.instance_variable_get(var))
      end
    end
  end

  private

  def get_variables_from(sender)
    variables = sender.instance_variables.dup
    variables.delete(:@context)
    variables.delete(:@delegate_sd_obj)
    variables
  end


end