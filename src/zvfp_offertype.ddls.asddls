@EndUserText.label: 'Projection view for Offer type'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity zvfp_offertype
  as projection on zvfI_offertype
{
  key Offertypeuuid,
      OfferType,
      OfferDesc,
      /* Associations */
       _subtype : redirected to composition child zvfp_offersubtype
}
