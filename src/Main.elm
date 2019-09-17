module Main exposing (main)

import Browser
import Element
import Element.Background
import Face
import Html exposing (Html)
import Time exposing (Posix)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { zone : Time.Zone
    , time : Posix
    }


type Msg
    = Tick Posix


init : () -> ( Model, Cmd msg )
init _ =
    ( Model Time.utc (Time.millisToPosix 0)
    , Cmd.none
    )


view : Model -> Html msg
view model =
    Element.layout [ Element.Background.color (Element.rgb255 0xBC 0xC1 0xC1) ]
        (Element.column []
            [ Element.text (textWatch model)
            , Element.html (Face.view model.time)
            ]
        )


textWatch : Model -> String
textWatch model =
    paddedHours model ++ ":" ++ paddedMinutes model ++ ":" ++ paddedSeconds model


update : Msg -> Model -> ( Model, Cmd msg )
update msg _ =
    case msg of
        Tick posix ->
            ( Model Time.utc posix, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 1000 Tick


paddedSeconds : Model -> String
paddedSeconds model =
    let
        unpadded =
            String.fromInt (Time.toSecond model.zone model.time)
    in
    case String.length unpadded of
        1 ->
            "0" ++ unpadded

        _ ->
            unpadded


paddedMinutes : Model -> String
paddedMinutes model =
    let
        unpadded =
            String.fromInt (Time.toMinute model.zone model.time)
    in
    case String.length unpadded of
        1 ->
            "0" ++ unpadded

        _ ->
            unpadded


paddedHours : Model -> String
paddedHours model =
    let
        unpadded =
            String.fromInt (Time.toHour model.zone model.time)
    in
    case String.length unpadded of
        1 ->
            "0" ++ unpadded

        _ ->
            unpadded
