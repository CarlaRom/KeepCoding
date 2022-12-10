select v.id_vehiculo, v.fecha_compra, hmv.matricula, grupo.nombre as grupo_empresarial, m.nombre as marca, model.nombre as modelo, c.nombre as color, v.num_total_km as kilometros_totales, a.nombre as aseguradora, hav.num_poliza  
from carla_romero_sansano.grupo_empresarial_marca grupo 
inner join carla_romero_sansano.marcas m on grupo.id_grupo_empresarial = m.id_grupo_empresarial
inner join carla_romero_sansano.modelos model on model.id_marca = m.id_marca 
inner join carla_romero_sansano.vehiculos v on v.id_modelo = model.id_modelo 
left join carla_romero_sansano.hist_matriculas_vehiculo hmv on v.id_vehiculo = hmv.id_vehiculo and v.fecha_compra = hmv.fecha_compra 
inner join carla_romero_sansano.colores c on v.id_color = c.id_color
left join carla_romero_sansano.hist_aseguradoras_vehiculo hav on v.id_vehiculo = hav.id_vehiculo and v.fecha_compra = hav.fecha_compra 
inner join carla_romero_sansano.aseguradoras a on hav.id_aseguradora = a.id_aseguradora


