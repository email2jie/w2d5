class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = nil
    @tail = nil

  end

  def [](i)
    each_with_index { |link, j| return link if i == j }

    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head == nil
  end

  def get(key)
    return nil if empty?
    return first.val if first.key == key
    queue = []
    queue << first.next unless first.next.nil?
    until queue.empty?
      link = queue.shift
      return link.val if link.key == key
      queue << link.next unless link.next.nil?
    end
    nil
  end

  def include?(key)
    !get(key).nil?
  end

  def insert(key, val)
    new_link = Link.new(key, val)

    if empty?
      @head = new_link
      @tail = new_link
    elsif include?(key)
      remove(key)
      insert(key, val)
    else
      last.next = new_link
      new_link.prev = last
      @tail = new_link
    end
  end

  def remove(key)
    removed_link = select { |link| link.key == key}.first
    if @head == removed_link
      @head = removed_link.next
      @head.prev = nil unless @head.nil?
    elsif @tail == removed_link
      @tail = removed_link.prev
      @tail.next = nil
    else
      removed_link.next.prev = removed_link.prev
      removed_link.prev.next = removed_link.next
    end

  end

  def each(&prc)
    return nil if empty?
    queue = [first]
    until queue.empty?
      link = queue.shift
      prc.call(link)
      queue << link.next unless link.next.nil?
    end
    self
  end


  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
