// ---------- Tecnologías ----------

class Tecnologia {
  const nombre
  const valorEnergetico
  const activa = true

  method nombre() = nombre
  method valorEnergetico() = valorEnergetico
  method activa() = activa
}

// ---------- Roles ----------

object estrategaCuantico {
  method cumpleCondicionDeElite(entrenador) = entrenador.precision() > 80
}

object arquitectoDeEnergia {
  method cumpleCondicionDeElite(entrenador) = entrenador.enSintonia()
}

object guiaMental {
  method cumpleCondicionDeElite(entrenador) = true
}

object foz {
  const rolesHomologados = #{estrategaCuantico, arquitectoDeEnergia, guiaMental}

  method validarRol(rol) {
    if (!rolesHomologados.contains(rol))
      throw new DomainException(message = "Rol no homologado por la FOZ")
  }
}

// ---------- Entrenadores ----------

class Entrenador {
  const ciclosSolares
  const enSintonia
  const precision    // de 0 a 100
  var rol

  method initialize() {
    foz.validarRol(rol)
  }

  method precision() = precision
  method enSintonia() = enSintonia
  method rol() = rol

  method rol(nuevoRol) {
    foz.validarRol(nuevoRol)
    rol = nuevoRol
  }

  method esEliteGalactico() = ciclosSolares > 10 && rol.cumpleCondicionDeElite(self)
}

// ---------- Equipos ----------

class Equipo {
  const nombre
  const energiaBase
  const entrenador
  const tecnologias = []

  method nombre() = nombre
  method energiaBase() = energiaBase
  method entrenador() = entrenador

  method tecnologiasActivas() = tecnologias.filter({ tecnologia => tecnologia.activa() })

  method energiaDeTecnologiasActivas() = self.tecnologiasActivas().sum({ tecnologia => tecnologia.valorEnergetico() })

  method energiaSinAjustes() = energiaBase + self.energiaDeTecnologiasActivas()

  method energiaTotal() = self.ajustarEnergia(self.energiaSinAjustes())

  method ajustarEnergia(energia) = energia

  method esDePrestigioUniversal()
}

class EquipoLuminico inherits Equipo {
  const radiacion
  const cristalesSolares = []

  override method ajustarEnergia(energia) =
    if (radiacion <= 5000) energia * 1.1 else energia

  override method esDePrestigioUniversal() =
    cristalesSolares.size() >= 3 &&
    entrenador.esEliteGalactico() &&
    !self.tecnologiasActivas().isEmpty()
}

class EquipoSintetico inherits Equipo {
  const procesamientoCentral    // en teraflops
  const modulosActivos
  const certificado

  method procesamientoCentral() = procesamientoCentral

  override method ajustarEnergia(energia) =
    if (modulosActivos > 5) energia * 0.8 else energia

  override method esDePrestigioUniversal() =
    certificado &&
    modulosActivos > 3 &&
    tecnologias.all({ tecnologia => tecnologia.activa() })
}

class EquipoEterico inherits Equipo {
  const fluctuacionDimensional
  const portalesAbiertos

  override method ajustarEnergia(energia) =
    if (self.esDePrestigioUniversal()) energia * 1.15 else energia

  override method esDePrestigioUniversal() =
    fluctuacionDimensional > 75 &&
    portalesAbiertos >= 2 &&
    self.tecnologiasActivas().size() >= 2
}
