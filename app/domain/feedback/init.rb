# frozen_string_literal: true

%w[entities]
  .each do |folder|
    require_relative "#{folder}/init"
  end
