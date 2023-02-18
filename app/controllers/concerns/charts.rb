module Charts
  def compute_benchmark_per_employee
    @footprint_benchmark_per_employee = 0
    companies = Company.sector(current_company.industry)
    @footprint_benchmark_per_employee = companies.sum do |company|
      if company.footprints.where(certified: true).size != 0
        company.footprints.where(certified: true).pluck(:ghg_result).sum.fdiv(company.footprints.where(certified: true).size * company.employee_nb)
      else
        0
      end
    end
    @footprint_benchmark_per_employee = @footprint_benchmark_per_employee.fdiv(100 * companies.size)
  end
end
