class Hash
  def increment_counter key
    self[key] ||= 0
    self[key] += 1
  end
end