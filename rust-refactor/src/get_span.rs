use syntax::ast::*;
use syntax::codemap::{Span, Spanned};
use syntax::ptr::P;

use util;


pub trait GetSpan {
    fn get_span(&self) -> Span;
}

impl<T> GetSpan for Spanned<T> {
    fn get_span(&self) -> Span {
        self.span
    }
}

impl<'a, T: GetSpan> GetSpan for &'a T {
    fn get_span(&self) -> Span {
        <T as GetSpan>::get_span(self)
    }
}

impl<T: GetSpan> GetSpan for P<T> {
    fn get_span(&self) -> Span {
        <T as GetSpan>::get_span(self)
    }
}

include!(concat!(env!("OUT_DIR"), "/get_span_gen.inc.rs"));