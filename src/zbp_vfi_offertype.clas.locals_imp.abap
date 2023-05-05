CLASS lhc_zvfI_offertype DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zvfI_offertype RESULT result.
    METHODS duplicateoffertype FOR VALIDATE ON SAVE
      IMPORTING keys FOR zvfi_offertype~duplicateoffertype.
    METHODS excelupload FOR MODIFY
      IMPORTING keys FOR ACTION zvfi_offertype~excelupload RESULT result.

ENDCLASS.

CLASS lhc_zvfI_offertype IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD duplicateoffertype.

    READ ENTITIES OF zvfi_offertype IN LOCAL MODE
    ENTITY zvfI_offertype
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_offertype).

    IF lt_offertype IS NOT INITIAL.

      SELECT offer_type FROM zvf_ofrtyp
      FOR ALL ENTRIES IN @lt_offertype
      WHERE offer_type = @lt_offertype-offertype
      INTO TABLE @DATA(lt_exist_offertype).

      LOOP AT lt_offertype INTO DATA(offertype).

        READ TABLE lt_exist_offertype TRANSPORTING NO FIELDS WITH KEY offer_type = offertype-OfferType.

        IF sy-subrc IS INITIAL.
          APPEND VALUE #( %tky = offertype-%tky ) TO failed-zvfi_offertype.
          APPEND VALUE #( %tky = offertype-%tky
                           %msg = new_message_with_text(
                                    severity = if_abap_behv_message=>severity-error
                                    text     = 'Offer Type already exists'
                                  ) ) TO reported-zvfi_offertype.
        ENDIF.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.

  METHOD excelUpload.

    DATA : lt_offertype    TYPE TABLE FOR CREATE zvfi_offertype,
           ls_offertype    TYPE STRUCTURE FOR CREATE zvfi_offertype,
           lt_offersubtype TYPE TABLE FOR CREATE zvfi_offertype\_subtype,
           ls_offersubtype TYPE STRUCTURE FOR CREATE zvfi_offertype\_subtype.

    LOOP AT keys INTO DATA(key).
      ls_offertype-OfferType = key-%param-offr_type.
      ls_offertype-OfferDesc = key-%param-offer_desc.

      APPEND ls_offertype TO lt_offertype.

      ls_offersubtype-%target = VALUE #( (
                                             OffrType = key-%param-offr_type
                                          OffrSubtype = key-%param-offr_subtype
                                         OffersubDesc = key-%param-offersub_desc
                                          ) ).

      APPEND ls_offersubtype TO lt_offersubtype.

      CLEAR : ls_offertype, ls_offersubtype.
    ENDLOOP.

    SORT : lt_offertype BY OfferType.

    DELETE ADJACENT DUPLICATES FROM lt_offertype COMPARING offertype.

*** Create offer types
    MODIFY ENTITIES OF zvfi_offertype IN LOCAL MODE
    ENTITY zvfI_offertype
    CREATE
    FIELDS ( OfferType OfferDesc )
    WITH lt_offertype
    FAILED failed
    REPORTED reported
    MAPPED DATA(ls_mapped).

*** Create offer Subtypes

    MODIFY ENTITIES OF zvfi_offertype IN LOCAL MODE
    ENTITY zvfI_offertype
    CREATE BY \_subtype
    FIELDS (
             OffrType
             OffrSubtype
             OffersubDesc
    )
    WITH lt_offersubtype
    FAILED failed
    REPORTED reported
    MAPPED mapped.

  ENDMETHOD.

ENDCLASS.
CLASS lhc_zvfi_offersubtype DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS duplicateoffersubtype FOR VALIDATE ON SAVE
      IMPORTING keys FOR zvfI_offersubtype~duplicateoffersubtype.

ENDCLASS.

CLASS lhc_zvfi_offersubtype IMPLEMENTATION.

  METHOD duplicateoffersubtype.

    READ ENTITIES OF zvfi_offertype IN LOCAL MODE
    ENTITY zvfI_offersubtype
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_offersubtype).

    IF lt_offersubtype IS NOT INITIAL.

      SELECT offr_type, offr_subtype FROM zvf_ofrsubtyp
      FOR ALL ENTRIES IN @lt_offersubtype
      WHERE offr_type = @lt_offersubtype-offrtype
        AND offr_subtype = @lt_offersubtype-offrsubtype
      INTO TABLE @DATA(lt_exist_offersubtype).

      LOOP AT lt_offersubtype INTO DATA(offersubtype).

        READ TABLE lt_exist_offersubtype TRANSPORTING NO FIELDS WITH KEY offr_type = offersubtype-OffrType.

        IF sy-subrc IS INITIAL.
          APPEND VALUE #( %tky = offersubtype-%tky ) TO failed-zvfi_offertype.
          APPEND VALUE #( %tky = offersubtype-%tky
                           %msg = new_message_with_text(
                                    severity = if_abap_behv_message=>severity-error
                                    text     = 'Offer Sub Type already exists'
                                  ) ) TO reported-zvfi_offertype.
        ENDIF.
      ENDLOOP.
    ENDIF.


  ENDMETHOD.

ENDCLASS.
