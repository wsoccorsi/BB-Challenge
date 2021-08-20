module DogsHelper
  
  # Params dog_counter: int
  # render_advertisement, conditionally returns True based on the current
  # dog iteration displayed
  # Returns Boolean
  def render_advertisement(dog_counter)
    return dog_counter % 2 == 0 && dog_counter != 0
  end
end
