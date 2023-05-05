@EndUserText.label: 'Projection view for Offer subtype'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity zvfp_offersubtype
  as projection on zvfI_offersubtype
{
  key Offersubtypeuuid,
      Offertyeuuid,
      OffrType,
      OffrSubtype,
      OffersubDesc,
      /* Associations */
      _Offertype : redirected to parent zvfp_offertype
}
