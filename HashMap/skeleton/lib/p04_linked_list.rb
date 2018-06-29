require 'byebug'

class Node

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

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    prev.next = @next
    prev = nil
    @next = nil

  end

  def inspect
    "<Node - key: #{@key} val: #{@val}"
  end
end

class LinkedList

  include Enumerable

  attr_accessor :head, :tail, :count, :first, :last

  def initialize(head = Node.new(:head), tail = Node.new(:tail))
    @head = head
    @head.next = tail
    @tail = tail
    @tail.prev = head
    @count = 0
    @first = nil
    @last = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @first
  end

  def last
    @last
  end

  def empty?
    @count == 0
  end

  def get(key)
    each {|node| return node.val if node.key == key}
    nil
  end

  def include?(key)
    node_list.any? {|node| node.key == key}
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.next = self.tail
    new_node.prev = self.tail.prev

    self.tail.prev.next = new_node
    self.tail.prev = new_node

    if count.zero?
      @first = new_node
    end

    @last = new_node

    @count += 1
  end

  def update(key, val)
    each {|node| node.val = val if node.key == key}
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.prev.next = node.next
        node.next.prev = node.prev

        if self.first == node
          self.first = node.prev
        end

        if self.last == node
          self.last = node.next
        end

        node.prev, node.next = nil, nil
      end
    end
  end

  def node_list
    nodes = []
    current = head

    until current.next.nil?
      nodes << current
      current = current.next
    end

    nodes
  end

  def each
    node_list.each do |node|
      next if node.key == :head || node.key == :tail

      yield node
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
