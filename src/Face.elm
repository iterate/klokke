module Face exposing (view)

import Color
import Html
import Segments exposing (segment0, segment1, segment2, segment3, segment4, segment5, segment6)
import Time exposing (Posix)
import TypedSvg
import TypedSvg.Attributes exposing (fill, transform, viewBox)
import TypedSvg.Core exposing (Svg)
import TypedSvg.Types exposing (Fill(..), Transform(..))


view : Posix -> Html.Html msg
view posix =
    let
        seconds =
            Time.toSecond Time.utc posix
                |> String.fromInt
                |> String.padLeft 2 '0'

        second0 =
            seconds |> String.right 1

        second1 =
            seconds
                |> String.right 2
                |> String.left 1

        minutes =
            Time.toMinute Time.utc posix
                |> String.fromInt
                |> String.padLeft 2 '0'

        minute0 =
            minutes |> String.right 1

        minute1 =
            minutes
                |> String.right 2
                |> String.left 1

        hours =
            Time.toHour Time.utc posix
                |> String.fromInt
                |> String.padLeft 2 '0'

        hour0 =
            hours |> String.right 1

        hour1 =
            hours
                |> String.right 2
                |> String.left 1
    in
    TypedSvg.svg [ viewBox 0 0 1000 160 ]
        [ digit hour1 0
        , digit hour0 100
        , digit minute1 200
        , digit minute0 300
        , digit second1 400
        , digit second0 500
        ]


digit : String -> Float -> Svg msg
digit second offset =
    TypedSvg.g [ transform [ Translate offset 0 ] ]
        [ segm second [ "1", "4" ] segment0
        , segm second [ "1", "2", "3", "7" ] segment1
        , segm second [ "5", "6" ] segment2
        , segm second [ "0", "1", "7" ] segment3
        , segm second [ "1", "3", "4", "5", "7", "9" ] segment4
        , segm second [ "2" ] segment5
        , segm second [ "1", "4", "7", "9" ] segment6
        ]


segm : String -> List String -> Svg msg -> Svg msg
segm second filter path =
    let
        status =
            not <| List.member second filter
    in
    TypedSvg.g [ fill <| Fill (kulour status) ] [ path ]


kulour : Bool -> Color.Color
kulour status =
    if status then
        Color.rgb 0x00 0x00 0x00

    else
        Color.rgb (0x7E / 255) (0x88 / 255) (0x91 / 255)
