<?php
/**
*@package pXP
*@file AsigVehiculo.php
*@author  (admin)
*@date 07-03-2019 13:53:18
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.AsigVehiculoVoBo={
	require:'../../../sis_rastreo/vista/asig_vehiculo/AsigVehiculoBase.php',
	requireclase:'Phx.vista.AsigVehiculoBase',
	title:'AsigVehiculoVoBo',
	nombreVista: 'AsigVehiculoVoBo',
	constructor:function(config){
		this.maestro=config.maestro;
		//console.log('maestro',this.maestro.id_funcionario);
		//this.Atributos[this.getIndAtributo('id_funcionario')].valorInicial = this.maestro.id_funcionario;
    	//llama al constructor de la clase padre
		Phx.vista.AsigVehiculoVoBo.superclass.constructor.call(this,config);
		this.init();
        this.bloquearMenus();

		},
	preparaMenu:function(n){
      var data = this.getSelectedData();
      var tb =this.tbar;
        Phx.vista.AsigVehiculoVoBo.superclass.preparaMenu.call(this,n);
        this.getBoton('btnElementSegu').enable();
        this.getBoton('btnViaje').enable();
        return tb
     }, 
     liberaMenu:function(){
        var tb = Phx.vista.AsigVehiculoVoBo.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('btnElementSegu').disable();
            this.getBoton('btnViaje').disable();
        }
       return tb
    },
    bnew:false,
    bedit:false,
    bdel:false,
    bsave:false,
    tabeast: [{
        url:'../../../sis_rastreo/vista/elemento_seg_equipo/ElementoSegEquipo.php',
        title:'Elem. seguridad y señalizacion',
        width:'50%',
        height:'50%',
        cls:'ElementoSegEquipo'
    }],
	}
</script>
		
		