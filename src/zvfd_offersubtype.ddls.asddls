@EndUserText.label: 'Abstract view for Offer subtype'
define abstract entity ZVFD_OFFERSUBTYPE
{
  key offr_type     : abap.char( 2 );
      offr_subtype  : abap.char( 2 );
      offer_desc    : abap.string( 0 );
      offersub_desc : abap.string( 0 );
}
