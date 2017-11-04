class Articulo < ApplicationRecord
  belongs_to :autor, optional: true
  has_many :comentarios, dependent: :destroy

  validates :titulo, presence: { :message => "no puede estar vacío" }
  validates :contenido, presence: { :message => "no puede estar vacío" }, 
  length: {minimum: 50, :message => "es demasiado corto, mínimo 50 caracteres"}

end
