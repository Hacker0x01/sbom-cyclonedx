# frozen_string_literal: true
# rbs_inline: enabled

# Impact Analysis - An assessment of the impact and exploitability of the vulnerability.
module Sbom
  module Cyclonedx
    class Analysis < SchemaObject
      attr_accessor :state #: ImpactAnalysisState

      attr_accessor :justification #: ImpactAnalysisJustification

      # Response - A response to the vulnerability by the manufacturer, supplier, or project responsible for the affected component or service. More than one response is allowed. Responses are strongly encouraged for vulnerabilities where the analysis state is exploitable.
      attr_accessor :response #: [Response]

      # Detail - Detailed description of the impact including methods used during assessment. If a vulnerability is not exploitable, this field should include specific details on why the component or service is not impacted by this vulnerability.
      attr_accessor :detail #: String

      # First Issued - The date and time (timestamp) when the analysis was first issued.
      attr_accessor :first_issued #: DateTime

      # Last Updated - The date and time (timestamp) when the analysis was last updated.
      attr_accessor :last_updated #: DateTime
    end
  end
end
