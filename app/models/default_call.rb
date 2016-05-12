class DefaultCall < Call
  def to_call
    call = Call.new attributes
  end
end
