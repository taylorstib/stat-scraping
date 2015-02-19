module CountGen
  # Generates an array of numbers, counting by how many player records
  # are on each HTML page. Allows other methods to paginate through the 
  # stat pages and collect them all.
  def generate_count(step_size=40)
    counts = (1..921).step(step_size) { |i| @array_of_count.push(i) }
    @array_of_count
  end
end