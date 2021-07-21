#!/usr/bin/env ruby

alphabet = ('A'..'Z').map { |s| [s, s.ord - 65] }.to_h

puts alphabet
