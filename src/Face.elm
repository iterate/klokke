module Face exposing (view)

import Color
import Html
import Segments exposing (segment0, segment1, segment2, segment3, segment4, segment5, segment6)
import Time exposing (Posix)
import TypedSvg
import TypedSvg.Attributes exposing (fill, viewBox)
import TypedSvg.Core exposing (Svg)
import TypedSvg.Types exposing (Fill(..))


view : Posix -> Html.Html msg
view posix =
    let
        digit =
            Time.toSecond Time.utc posix
                |> String.fromInt
                |> String.right 1
    in
    TypedSvg.svg [ viewBox 0 0 1000 1600 ]
        [ segm digit [ "1", "4" ] segment0
        , segm digit [ "1", "2", "3", "7" ] segment1
        , segm digit [ "5", "6" ] segment2
        , segm digit [ "0", "1", "7" ] segment3
        , segm digit [ "1", "3", "4", "5", "7", "9" ] segment4
        , segm digit [ "2" ] segment5
        , segm digit [ "1", "4", "7", "9" ] segment6
        ]


segm : String -> List String -> Svg msg -> Svg msg
segm digit filter path =
    let
        status =
            not <| List.member digit filter
    in
    TypedSvg.g [ fill <| Fill (kulour status) ] [ path ]


kulour : Bool -> Color.Color
kulour status =
    if status then
        Color.rgb 0x00 0x00 0x00

    else
        Color.rgb (0x7E / 255) (0x88 / 255) (0x91 / 255)
