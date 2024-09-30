# frozen_string_literal: true
# rbs_inline: enabled

# Call Stack - Evidence of the components use through the callstack.
module Sbom
  module Cyclonedx
    class Callstack < SchemaObject
      # Frames - Within a call stack, a frame is a discrete unit that encapsulates an execution context, including local variables, parameters, and the return address. As function calls are made, frames are pushed onto the stack, forming an array-like structure that orchestrates the flow of program execution and manages the sequence of function invocations.
      attr_accessor :frames #: [Frame]
    end
  end
end
