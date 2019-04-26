#!/usr/bin/env ruby

# This script reads the assembler code from STDIN and
# rewrites all EQU directives that are not declared as
# labels.
#
# This is useful to merge different assembler sources that
# are declaring the symbols of one file in the rest using
# EQUs. Just pass all assembler files contents to the script
# so it can rewrite the EQUs ensuring they will not be repeated.
#
# Usage example:
#
#    $ cat bios.asm basic1.asm basic2.asm | /path/to/gen-equs.rb
#

lines = []
ARGF.each do |line|
    line = line.strip
    if !line.empty? && line.split[0][0] != ';'
        lines <<= line
    end
end

labels = lines.
    map { |l| l.split }.
    select { |l| l[0][-1] == ':' }.
    map { |tks| [tks[0][0..-2], nil] }.
    to_h

equs = lines.
    map { |l| l.split }.
    select { |tks| !tks[1].nil? && tks[1].downcase == 'equ' }.
    map { |tks| [tks[0], tks[2]] }.
    to_h.
    select { |l,a| !labels.include?(l) }


new_lines = equs.
    sort_by { |lab, addr| addr }.
    map do |lab, addr|
        line = lab
        line += ' ' * (16 - lab.size)
        line += 'EQU     '
        if addr.nil?
            puts "Label #{lab} is nil"
        end
        line += addr
    end

new_lines.each do |line|
    puts line
end
