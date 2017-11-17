CREATE OR REPLACE FUNCTION "ras"."ft_tipo_evento_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Rastreo Satelital
 FUNCION: 		ras.ft_tipo_evento_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'ras.ttipo_evento'
 AUTOR: 		 (admin)
 FECHA:	        30-07-2017 15:17:26
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_tipo_evento	integer;
			    
BEGIN

    v_nombre_funcion = 'ras.ft_tipo_evento_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'RAS_EVENT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		30-07-2017 15:17:26
	***********************************/

	if(p_transaccion='RAS_EVENT_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into ras.ttipo_evento(
			codigo,
			estado_reg,
			nombre,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.codigo,
			'activo',
			v_parametros.nombre,
			v_parametros._nombre_usuario_ai,
			now(),
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_tipo_evento into v_id_tipo_evento;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Eventos almacenado(a) con exito (id_tipo_evento'||v_id_tipo_evento||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_evento',v_id_tipo_evento::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'RAS_EVENT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		30-07-2017 15:17:26
	***********************************/

	elsif(p_transaccion='RAS_EVENT_MOD')then

		begin
			--Sentencia de la modificacion
			update ras.ttipo_evento set
			codigo = v_parametros.codigo,
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_tipo_evento=v_parametros.id_tipo_evento;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Eventos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_evento',v_parametros.id_tipo_evento::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'RAS_EVENT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		30-07-2017 15:17:26
	***********************************/

	elsif(p_transaccion='RAS_EVENT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from ras.ttipo_evento
            where id_tipo_evento=v_parametros.id_tipo_evento;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Eventos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_evento',v_parametros.id_tipo_evento::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "ras"."ft_tipo_evento_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
