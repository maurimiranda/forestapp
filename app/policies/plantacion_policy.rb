class PlantacionPolicy < ApplicationPolicy

  def mass_edit?
    user.editor?
  end

  def mass_update?
    user.editor?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
