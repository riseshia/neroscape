module CreatersHelper
  def role_explain(join)
    role = ""
    case join.role
    when 1
      role = "원화"
    when 2
      role = "시나리오"
    when 3
      role = "음악"
    when 4
      role = "캐릭터 디자인"
    when 5
      role = "CV"
    when 6
      role = "가수"
    when 7
      role = "기타"
    end

    role += ": #{join.role_detail_name}" if join.role_detail_name

    return "(#{role})"
  end
end
