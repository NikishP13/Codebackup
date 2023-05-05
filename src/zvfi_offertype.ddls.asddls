@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Offer type'
define root view entity zvfI_offertype
  as select from zvf_ofrtyp
  composition [1..*] of zvfI_offersubtype as _subtype
{
  key zvf_ofrtyp.offertypeuuid as Offertypeuuid,
      zvf_ofrtyp.offer_type as OfferType,
      zvf_ofrtyp.offer_desc as OfferDesc,
      _subtype
}
