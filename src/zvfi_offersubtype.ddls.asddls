@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Offer subtype'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity zvfI_offersubtype
  as select from zvf_ofrsubtyp
  association to parent zvfI_offertype as _Offertype on $projection.Offertyeuuid = _Offertype.Offertypeuuid
  
{
  key zvf_ofrsubtyp.offersubtypeuuid as Offersubtypeuuid,
      zvf_ofrsubtyp.offertyeuuid     as Offertyeuuid,
      zvf_ofrsubtyp.offr_type        as OffrType,
      zvf_ofrsubtyp.offr_subtype     as OffrSubtype,
      zvf_ofrsubtyp.offersub_desc    as OffersubDesc,
      _Offertype
}
