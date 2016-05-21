require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)

    calc!(key) if @map.get(key).nil?
    # link = @store.select {|link| link.key == key}.first
    # update_link!(link) unless link.nil?
    @map.get(key).val

  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @store.insert(key, @prc.call(key))
    # link = @store.select {|link| link.key == key}.first
    @map.set(key, @store.last)
    eject! if count > @max
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.insert(link.key, link.val)
  end

  def eject!
    key = @store.first.key
    @map.delete(key)
    @store.remove(key)
  end
end
