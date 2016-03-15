class IssueRepresenter
  attr_reader :representable

  def self.represent_items(representables)
    @@representables ||= representables.map { |representable| new(representable).represent }
  end

  def self.represent(representable)
    new(representable).represent
  end

  def initialize(representable)
    @representable = representable
  end

  def represent
    {
      created_at: representable.created_at,
      closed_at: representable.closed_at
    }
  end
end
